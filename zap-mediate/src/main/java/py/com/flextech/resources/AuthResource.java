package py.com.flextech.resources;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.eclipse.microprofile.rest.client.inject.RestClient;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.inject.Inject;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.HeaderParam;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import py.com.flextech.models.StartSession;
import py.com.flextech.models.StartSessionResponse;
import py.com.flextech.models.dto.ChatResponseDto;
import py.com.flextech.models.dto.GenerateTokenResponse;
import py.com.flextech.models.dto.LogoutResponseDto;
import py.com.flextech.models.dto.MessageDto;
import py.com.flextech.models.dto.file.SendFileResponse;
import py.com.flextech.models.dto.text.SendMessage;
import py.com.flextech.models.dto.text.WhatsAppSendFileDto;
import py.com.flextech.models.dto.text.WhatsAppWithSendFile;
import py.com.flextech.services.AuthService;
import py.com.flextech.services.EventService;

@Path("/api")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class AuthResource {

  @Inject
  @RestClient
  AuthService authService;

  @Inject
  EventService eventService;

  @Inject
  @ConfigProperty(name = "wpp.secret")
  String wppSecret;

  private Map<String, String> sessionMap = new HashMap<>();

  @GET
  @Path("/show")
  public Response showAllSessions() throws JsonMappingException, JsonProcessingException {
    String response = authService.showAllSessions(wppSecret);
    ObjectMapper om = new ObjectMapper();
    JsonNode root = om.readTree(response);
    JsonNode respNode = root.get("response");
    List<String> sessionesIniciadas = new ArrayList<String>();
    if (respNode.isArray()) {
      for (JsonNode node : respNode) {
        GenerateTokenResponse gtr = authService.generateToken(node.asText(), wppSecret);
        sessionMap.put(gtr.getSession(), gtr.getToken());
        sessionesIniciadas.add(gtr.getSession());
      }
    }
    String stringResponse = "Fueron generados los tokens de: " + String.join(", ", sessionesIniciadas);
    System.out.println(stringResponse);
    return Response.ok(stringResponse).build();
  }

  // REQUISICIONES CON TOKEN

  @POST
  @Path("/start")
  public Response start(StartSession session)
      throws Exception {
    GenerateTokenResponse generateTokenResponse;
    StartSessionResponse startSessionResponse;
    if (session != null) {
      generateTokenResponse = authService.generateToken(session.getSession(), wppSecret);
      sessionMap.put(session.getSession(), generateTokenResponse.getToken());
      startSessionResponse = eventService.startSession(session.getSession(), generateTokenResponse.getToken());
      return Response.ok(startSessionResponse, MediaType.APPLICATION_JSON).build();
    } else {

      return Response.accepted().build();
    }
  }

  @POST
  @Path("/sendText")
  public Response sendMessage(SendMessage message)
      throws IOException, InterruptedException {
    if (sessionMap.isEmpty()) {
      showAllSessions();
    }
    MessageDto dto = new MessageDto();
    dto.setMessage(message.getMessage());
    List<String> phones = new ArrayList<>();
    phones.add(message.getPhone());
    dto.setPhone(phones);
    ChatResponseDto response = eventService.sendMessage(message.getSession(), sessionMap.get(
        message.getSession()), dto);
    if (response != null) {
      return Response.ok(response).build();
    } else {
      return Response.accepted(response).build();
    }
  }

  @POST
  @Path("/sendFile64")
  public Response sendFile64(@HeaderParam("sessionkey") String session, WhatsAppWithSendFile file)
      throws IOException, InterruptedException {
    if (sessionMap.isEmpty()) {
      showAllSessions();
    }
    WhatsAppSendFileDto dto = new WhatsAppSendFileDto();
    dto.setPhone(file.getNumber());
    dto.setFilename(file.getFileName());
    dto.setBase64(file.getPath());
    dto.setCaption(file.getCaption());
    dto.setMessage(file.getCaption());
    SendFileResponse response = eventService.sendFile64(session, sessionMap.get(session), dto);
    if (response != null) {
      return Response.ok(response).build();
    } else {
      return Response.accepted(response).build();
    }

  }

  @POST
  @Path("/logout-session")
  public LogoutResponseDto logou(@QueryParam("sessionKey") String sessionKey) throws Exception {
    LogoutResponseDto response = eventService.logoutSession(sessionKey, sessionMap.get(sessionKey));
    if (response != null) {
      return response;
    } else {
      throw new Exception();
    }
  }

}
