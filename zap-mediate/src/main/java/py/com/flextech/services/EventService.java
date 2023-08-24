package py.com.flextech.services;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpClient.Version;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import org.eclipse.microprofile.config.inject.ConfigProperty;

import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.context.control.ActivateRequestContext;
import jakarta.inject.Inject;
import jakarta.websocket.server.PathParam;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import py.com.flextech.dao.GenerateTokenResponseDao;
import py.com.flextech.models.StartSessionResponse;
import py.com.flextech.models.dto.ChatResponseDto;
import py.com.flextech.models.dto.LogoutResponseDto;
import py.com.flextech.models.dto.MessageDto;

@ApplicationScoped
public class EventService {

  @ConfigProperty(name = "base.url")
  @Inject
  private String baseUrl;

  @ConfigProperty(name = "wpp.token")
  @Inject
  private String token;

  @Inject
  private GenerateTokenResponseDao dao;

  @POST
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  @ActivateRequestContext
  public StartSessionResponse startSession(String sessionKey)
      throws Exception {
    HttpClient httpClient = HttpClient.newHttpClient();
    ObjectMapper om = new ObjectMapper();

    URI uri = URI.create(baseUrl + "/api/" + sessionKey + "/start-session");

    HttpRequest request = HttpRequest.newBuilder(uri).header("Authorization",
        "Bearer "
            + token)
        .POST(HttpRequest.BodyPublishers.noBody()).version(Version.HTTP_1_1).build();

    HttpResponse<String> response = httpClient.send(request,
        HttpResponse.BodyHandlers.ofString());
    if (response.statusCode() == 200) {
      StartSessionResponse startSessionResponse = om.readValue(response.body(),
          StartSessionResponse.class);
      return startSessionResponse;
    } else {
      // dao.deleteBySessionID(sessionKey);
      throw new RuntimeException("Error al iniciar sesion");
    }
  }

  @POST
  public ChatResponseDto sendMessage(String sessionKey, MessageDto message)
      throws IOException, InterruptedException {
    HttpClient httpClient = HttpClient.newHttpClient();
    ObjectMapper om = new ObjectMapper();
    URI uri = URI.create(baseUrl + "/api/" + sessionKey + "/send-message");
    String json = om.writeValueAsString(message);

    HttpRequest request = HttpRequest.newBuilder(uri).header("Authorization",
        "Bearer " + token).header("Content-Type", "application/json")
        .POST(HttpRequest.BodyPublishers.ofString(json)).version(Version.HTTP_1_1).build();

    HttpResponse<String> response = httpClient.send(request,
        HttpResponse.BodyHandlers.ofString());
    if (response.statusCode() == 201) {
      ChatResponseDto chatResponseDto = om.readValue(response.body(),
          ChatResponseDto.class);
      return chatResponseDto;
    } else {
      throw new RuntimeException("Error al enviar mensjae");
    }
  }

  @POST
  public LogoutResponseDto logoutSession(@PathParam("session") String sessionKey)
      throws IOException, InterruptedException {
    HttpClient httpClient = HttpClient.newHttpClient();
    ObjectMapper om = new ObjectMapper();
    String token = "asdasd";
    URI uri = URI.create(baseUrl + "/api/" + sessionKey + "/logout-session");

    HttpRequest request = HttpRequest.newBuilder(uri).header("Authorization", "Bearer " + token)
        .POST(HttpRequest.BodyPublishers.noBody()).build();

    HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
    if (response.statusCode() == 200) {
      LogoutResponseDto logoutResponseDto = om.readValue(response.body(), LogoutResponseDto.class);
      return logoutResponseDto;
    } else {
      throw new RuntimeException("Error al enviar mensaje");
    }
  }
}
