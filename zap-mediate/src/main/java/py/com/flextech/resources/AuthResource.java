package py.com.flextech.resources;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.eclipse.microprofile.rest.client.inject.RestClient;

import jakarta.annotation.security.PermitAll;
import jakarta.inject.Inject;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import py.com.flextech.dao.GenerateTokenResponseDao;
import py.com.flextech.models.StartSession;
import py.com.flextech.models.StartSessionResponse;
import py.com.flextech.models.dto.ChatResponseDto;
import py.com.flextech.models.dto.GenerateTokenResponse;
import py.com.flextech.models.dto.LogoutResponseDto;
import py.com.flextech.models.dto.MessageDto;
import py.com.flextech.models.dto.SendMessage;
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

  @Inject
  GenerateTokenResponseDao dao;

  @POST
  @Path("/start")
  public Response start(StartSession session)
      throws Exception {
    GenerateTokenResponse generateTokenResponse;
    StartSessionResponse startSessionResponse;
    if (session != null) {
      generateTokenResponse = authService.generateToken(session.getSession(), "gKN3S66WazodrdoM");
      startSessionResponse = eventService.startSession(generateTokenResponse.getSession());
      return Response.ok(startSessionResponse, MediaType.APPLICATION_JSON).build();
    } else {

      return Response.accepted().build();
    }
  }

  @POST
  @PermitAll
  @Path("/qrcode")
  @Consumes(MediaType.TEXT_PLAIN)
  public Response refreshQr(String qr) {
    System.out.println("qr: " + qr);
    return Response.ok(qr).build();
  }

  @POST
  @PermitAll
  @Path("/generate-token")
  public Response generateToken(@QueryParam("sessionKey") String sessionKey) {
    System.out.println("sessionKey: " + sessionKey);
    GenerateTokenResponse response = authService.generateToken(sessionKey, wppSecret);
    if (response != null) {
      dao.save(response);
      return Response.ok(response).build();
    } else {
      return Response.accepted(response).build();
    }
  }

  @GET
  @Path("/show")
  public Response showAllSessions() {
    String response = authService.showAllSessions(wppSecret);
    if (response != null) {
      return Response.ok(response).build();
    } else {
      return Response.accepted(response).build();
    }
  }

  // REQUISICIONES CON TOKEN

  @POST
  @Path("/start-session")
  public Response startSession(
      @QueryParam("sessionKey") String sessionKey)
      throws Exception {
    System.out.println("sessionKey: " + sessionKey);
    StartSessionResponse response = eventService.startSession(sessionKey);
    if (response != null) {
      return Response.ok(response).build();
    } else {
      return Response.accepted(response).build();
    }
  }

  @POST
  @Path("/sendText")
  public Response sendMessage(SendMessage message)
      throws IOException, InterruptedException {
    MessageDto dto = new MessageDto();
    dto.setMessage(message.getMessage());
    List<String> phones = new ArrayList<>();
    phones.add(message.getPhone());
    dto.setPhone(phones);
    ChatResponseDto response = eventService.sendMessage(message.getSession(), dto);
    if (response != null) {
      return Response.ok(response).build();
    } else {
      return Response.accepted(response).build();
    }
  }

  @POST
  @Path("/logout-session")
  public LogoutResponseDto logou(@QueryParam("sessionKey") String sessionKey) throws Exception {
    LogoutResponseDto response = eventService.logoutSession(sessionKey);
    if (response != null) {
      return response;
    } else {
      throw new Exception();
    }
  }

}
