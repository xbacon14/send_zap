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
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import py.com.flextech.models.StartSessionResponse;
import py.com.flextech.models.dto.ChatResponseDto;
import py.com.flextech.models.dto.LogoutResponseDto;
import py.com.flextech.models.dto.MessageDto;
import py.com.flextech.models.dto.file.SendFileResponse;
import py.com.flextech.models.dto.text.WhatsAppSendFileDto;
import py.com.flextech.utils.StringUtils;

@ApplicationScoped
public class EventService {

  @ConfigProperty(name = "base.url")
  @Inject
  private String baseUrl;

  @POST
  @Consumes(MediaType.APPLICATION_JSON)
  @Produces(MediaType.APPLICATION_JSON)
  @ActivateRequestContext
  public StartSessionResponse startSession(String sessionKey, String token)
      throws Exception {
    HttpClient httpClient = HttpClient.newHttpClient();
    ObjectMapper om = new ObjectMapper();
    sessionKey = StringUtils.normalizaText(sessionKey);

    URI uri = URI.create(baseUrl + "/api/" + sessionKey + "/start-session");
    System.out.println("Session: " + sessionKey + " Token: " + token);
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
      throw new RuntimeException("Error al iniciar sesion " + response.body());
    }
  }

  @POST
  public ChatResponseDto sendMessage(String sessionKey, String token, MessageDto message)
      throws IOException, InterruptedException {
    HttpClient httpClient = HttpClient.newHttpClient();
    ObjectMapper om = new ObjectMapper();
    sessionKey = StringUtils.normalizaText(sessionKey);
    URI uri = URI.create(baseUrl + "/api/" + sessionKey + "/send-message");
    String json = om.writeValueAsString(message);

    HttpRequest request = HttpRequest.newBuilder(uri).header("Authorization",
        "Bearer " + token).header("Content-Type", "application/json")
        .POST(HttpRequest.BodyPublishers.ofString(json)).version(Version.HTTP_1_1).build();

    HttpResponse<String> response = httpClient.send(request,
        HttpResponse.BodyHandlers.ofString());
    if (response.statusCode() == 201) {
      ChatResponseDto chatResponseDto = new ChatResponseDto(200l, message.getMessage());
      return chatResponseDto;
    } else {
      throw new RuntimeException("Error al enviar mensaje" + response.body());
    }
  }

  @POST
  public SendFileResponse sendFile64(String sessionKey, String token, WhatsAppSendFileDto dto)
      throws IOException, InterruptedException {
    HttpClient httpClient = HttpClient.newHttpClient();
    ObjectMapper om = new ObjectMapper();
    sessionKey = StringUtils.normalizaText(sessionKey);
    URI uri = URI.create(baseUrl + "/api/" + sessionKey + "/send-file-base64");
    String json = om.writeValueAsString(dto);

    HttpRequest request = HttpRequest.newBuilder(uri).header("Authorization",
        "Bearer " + token).header("Content-Type", "application/json")
        .POST(HttpRequest.BodyPublishers.ofString(json)).version(Version.HTTP_1_1).build();

    HttpResponse<String> response = httpClient.send(request,
        HttpResponse.BodyHandlers.ofString());
    if (response.statusCode() == 201) {
      SendFileResponse fileSendResponse = om.readValue(response.body(),
          SendFileResponse.class);
      return fileSendResponse;
    } else {
      throw new RuntimeException("Error al enviar archivo" + response.body());
    }
  }

  @POST
  public LogoutResponseDto logoutSession(String sessionKey, String token)
      throws IOException, InterruptedException {
    HttpClient httpClient = HttpClient.newHttpClient();
    ObjectMapper om = new ObjectMapper();
    sessionKey = StringUtils.normalizaText(sessionKey);
    URI uri = URI.create(baseUrl + "/api/" + sessionKey + "/logout-session");

    HttpRequest request = HttpRequest.newBuilder(uri).header("Authorization", "Bearer " + token)
        .version(Version.HTTP_1_1)
        .POST(HttpRequest.BodyPublishers.noBody()).build();

    HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
    if (response.statusCode() == 200) {
      LogoutResponseDto logoutResponseDto = om.readValue(response.body(), LogoutResponseDto.class);
      return logoutResponseDto;
    } else {
      throw new RuntimeException("Error al enviar mensaje " + response.body());
    }
  }

}
