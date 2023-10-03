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

import jakarta.annotation.security.PermitAll;
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
import py.com.flextech.models.dto.ChatResponseDto;
import py.com.flextech.models.dto.GenerateTokenResponse;
import py.com.flextech.models.dto.LogoutResponseDto;
import py.com.flextech.models.dto.MessageDto;
import py.com.flextech.models.dto.file.ResponseToComercial;
import py.com.flextech.models.dto.file.SendFileResponse;
import py.com.flextech.models.dto.text.SendMessage;
import py.com.flextech.models.dto.text.WhatsAppSendFileDto;
import py.com.flextech.models.dto.text.WhatsAppWithSendFile;
import py.com.flextech.models.uazapi.session.UazapiCreateInstance;
import py.com.flextech.models.uazapi.session.UazapiCreateInstanceResponse;
import py.com.flextech.models.uazapi.session.UazapiLogoutResponse;
import py.com.flextech.services.AuthService;
import py.com.flextech.services.EventService;
import py.com.flextech.services.UazapiEventService;

@Path("/")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class AuthResource {

  @Inject
  @RestClient
  AuthService authService;

  @Inject
  EventService eventService;

  @Inject
  UazapiEventService uazapiEventService;

  @Inject
  @ConfigProperty(name = "wpp.secret")
  String wppSecret;

  @Inject
  @ConfigProperty(name = "zap.mediate.token")
  String zapMediateToken;

  private Map<String, String> sessionMap = new HashMap<>();

  private List<String> sessionesUazapi = new ArrayList<String>() {
    {
      add("FLEX_PDV_VENDAS");
      add("SISTEMA_FLEXTECH_MENSUALIDAD");
      add("ITALUS");
    }
  };

  @GET
  @PermitAll
  @Path("show")
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
  @PermitAll
  @Path("start")
  public Response start(StartSession session)
      throws Exception {
    UazapiCreateInstance instance = new UazapiCreateInstance(session.getSession(), zapMediateToken);
    UazapiCreateInstanceResponse response = uazapiEventService.startSession(instance);
    if (response.getHash().getApikey().startsWith("Ya", 0)) {
      return Response.status(403).entity(response).build();
    } else if (response.getInstance().getStatus().compareTo("created") == 0) {
      return Response.ok(response).build();
    } else {
      throw new Exception();
    }

  }

  @GET
  @PermitAll
  @Path("getQrCode")
  public Response atualizaQRCode(StartSession session) throws IOException, InterruptedException {
    return Response.ok(uazapiEventService.refreshQr(session.getSession())).build();
  }

  @POST
  @PermitAll
  @Path("sendText")
  public ChatResponseDto sendMessage(SendMessage message)
      throws IOException, InterruptedException {
    verifySession(message.getSession());
    MessageDto dto = new MessageDto();
    dto.setMessage(message.getText());
    List<String> phones = new ArrayList<>();
    phones.add(message.getNumber());
    dto.setPhone(phones);
    if (sessionesUazapi.contains(message.getSession())) {
      System.out.println("uazapi session: " + message.getSession());
      return uazapiEventService.sendMessage(message.getSession(), zapMediateToken, dto);
    } else {
      return eventService.sendMessage(message.getSession(), sessionMap.get(
          message.getSession()), dto);
    }

  }

  @POST
  @PermitAll
  @Path("sendFile64")
  public ResponseToComercial sendFile64(@HeaderParam("sessionkey") String session, WhatsAppWithSendFile file)
      throws IOException, InterruptedException {
    verifySession(session);
    WhatsAppSendFileDto dto = new WhatsAppSendFileDto();
    dto.setPhone(file.getNumber());
    dto.setFilename(file.getFileName());
    dto.setBase64(file.getPath());
    dto.setCaption(file.getCaption());
    dto.setMessage(file.getCaption());
    SendFileResponse response;
    if (sessionesUazapi.contains(session)) {
      response = uazapiEventService.sendFile64(session, zapMediateToken, dto);
    } else {
      response = eventService.sendFile64(session, sessionMap.get(session),
          dto);
    }
    return new ResponseToComercial(200l, response.getStatus());

  }

  @POST
  @PermitAll
  @Path("logout-session")
  public LogoutResponseDto logou(@QueryParam("sessionKey") String sessionKey) throws Exception {
    if (sessionesUazapi.contains(sessionKey)) {
      UazapiLogoutResponse response = uazapiEventService.logoutSession(sessionKey);
      return new LogoutResponseDto("200", response.getMessage());
    } else {
      verifySession(sessionKey);
      LogoutResponseDto response = eventService.logoutSession(sessionKey, sessionMap.get(sessionKey));
      if (response != null) {
        return response;
      } else {
        throw new Exception();
      }
    }
  }

  private void verifySession(String sessionKey) throws JsonMappingException, JsonProcessingException {
    if (sessionMap.isEmpty() || !sessionMap.containsKey(sessionKey)) {
      showAllSessions();
    }
  }
}
