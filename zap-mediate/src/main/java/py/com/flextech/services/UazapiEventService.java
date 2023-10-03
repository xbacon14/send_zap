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
import jakarta.inject.Inject;
import py.com.flextech.models.dto.ChatResponseDto;
import py.com.flextech.models.dto.MessageDto;
import py.com.flextech.models.dto.file.SendFileResponse;
import py.com.flextech.models.dto.text.WhatsAppSendFileDto;
import py.com.flextech.models.uazapi.qr_code.UazapiRefreshQRCodeResponse;
import py.com.flextech.models.uazapi.send_file.UazapiMediaMessage;
import py.com.flextech.models.uazapi.send_file.UazapiSendFile64Dto;
import py.com.flextech.models.uazapi.send_text.UazapiMessageOptions;
import py.com.flextech.models.uazapi.send_text.UazapiSendTextDto;
import py.com.flextech.models.uazapi.send_text.UazapiTextMessage;
import py.com.flextech.models.uazapi.session.UazapiCreateInstance;
import py.com.flextech.models.uazapi.session.UazapiCreateInstanceHash;
import py.com.flextech.models.uazapi.session.UazapiCreateInstanceResponse;
import py.com.flextech.models.uazapi.session.UazapiLogoutResponse;
import py.com.flextech.utils.StringUtils;

@ApplicationScoped
public class UazapiEventService implements IEventService {

  @ConfigProperty(name = "uazapi.base.url")
  @Inject
  private String baseUrl;

  @ConfigProperty(name = "uazapi.global.apikey")
  @Inject
  private String globalKey;

  @Override
  public UazapiCreateInstanceResponse startSession(UazapiCreateInstance instance)
      throws IOException, InterruptedException {
    HttpClient httpClient = HttpClient.newHttpClient();
    ObjectMapper om = new ObjectMapper();
    instance.setInstanceName(StringUtils.normalizaText(instance.getInstanceName()));
    String json = om.writeValueAsString(instance);

    URI uri = URI.create(baseUrl + "/instance/create");
    // System.out.println("Session: " + sessionKey + " Token: " + token);
    HttpRequest request = HttpRequest.newBuilder(uri).header("apikey",
        globalKey).header("Content-Type", "application/json")
        .POST(HttpRequest.BodyPublishers.ofString(json)).version(Version.HTTP_1_1).build();

    HttpResponse<String> response = httpClient.send(request,
        HttpResponse.BodyHandlers.ofString());
    if (response.statusCode() == 201) {
      UazapiCreateInstanceResponse startSessionResponse = om.readValue(response.body(),
          UazapiCreateInstanceResponse.class);
      return startSessionResponse;
    } else if (response.statusCode() == 403) {
      return new UazapiCreateInstanceResponse(
          new UazapiCreateInstanceHash("Ya existe un usuario con el nombre: " + instance.getInstanceName()));
    } else {
      throw new RuntimeException("Error al iniciar sesion " + response.body());
    }
  }

  public UazapiRefreshQRCodeResponse refreshQr(String instance)
      throws IOException, InterruptedException {
    HttpClient httpClient = HttpClient.newHttpClient();
    ObjectMapper om = new ObjectMapper();

    URI uri = URI.create(baseUrl + "/instance/connectionState/" + instance);
    // System.out.println("Session: " + sessionKey + " Token: " + token);
    HttpRequest request = HttpRequest.newBuilder(uri).header("apikey",
        globalKey).header("Content-Type", "application/json")
        .GET().version(Version.HTTP_1_1).build();

    HttpResponse<String> response = httpClient.send(request,
        HttpResponse.BodyHandlers.ofString());
    if (response.statusCode() == 200) {
      UazapiRefreshQRCodeResponse startSessionResponse = om.readValue(response.body(),
          UazapiRefreshQRCodeResponse.class);
      return startSessionResponse;
    } else {
      throw new RuntimeException("Error al actualizar el qr " + response.body());
    }
  }

  @Override
  public ChatResponseDto sendMessage(String instanceName, String token, MessageDto message)
      throws IOException, InterruptedException {
    HttpClient httpClient = HttpClient.newHttpClient();
    ObjectMapper om = new ObjectMapper();
    instanceName = StringUtils.normalizaText(instanceName);
    URI uri = URI.create(baseUrl + "/message/sendText/" + instanceName);
    UazapiSendTextDto dto = new UazapiSendTextDto(message.getPhone().get(0),
        new UazapiTextMessage(message.getMessage()),
        new UazapiMessageOptions(200l));
    String json = om.writeValueAsString(dto);

    HttpRequest request = HttpRequest.newBuilder(uri).header("apikey",
        token).header("Content-Type", "application/json")
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

  @Override
  public SendFileResponse sendFile64(String instanceName, String token, WhatsAppSendFileDto dto)
      throws IOException, InterruptedException {
    HttpClient httpClient = HttpClient.newHttpClient();
    ObjectMapper om = new ObjectMapper();
    instanceName = StringUtils.normalizaText(instanceName);
    URI uri = URI.create(baseUrl + "/message/sendMedia/" + instanceName);

    String[] baseFile = dto.getBase64().split(",");
    dto.setBase64(baseFile[baseFile.length - 1]);

    UazapiSendFile64Dto sendFile64Dto = new UazapiSendFile64Dto(dto.getPhone(), new UazapiMessageOptions(200l),
        new UazapiMediaMessage("document", dto.getFilename(), dto.getCaption(), dto.getBase64()));

    String json = om.writeValueAsString(sendFile64Dto);
    HttpRequest request = HttpRequest.newBuilder(uri).header("apikey",
        token).header("Content-Type", "application/json")
        .POST(HttpRequest.BodyPublishers.ofString(json)).version(Version.HTTP_1_1).build();

    HttpResponse<String> response = httpClient.send(request,
        HttpResponse.BodyHandlers.ofString());
    if (response.statusCode() == 201) {
      // UazapiSendFileResponse fileSendResponse = om.readValue(response.body(),
      // UazapiSendFileResponse.class);
      SendFileResponse sendFileResponse = new SendFileResponse("success");
      return sendFileResponse;
    } else {
      throw new RuntimeException("Error al enviar archivo" + response.body());
    }
  }

  @Override
  public UazapiLogoutResponse logoutSession(String instanceName) throws IOException, InterruptedException {
    HttpClient httpClient = HttpClient.newHttpClient();
    ObjectMapper om = new ObjectMapper();
    URI uri = URI.create(baseUrl + "/instance/logout/" + instanceName);

    HttpRequest request = HttpRequest.newBuilder(uri).header("apikey", globalKey)
        .version(Version.HTTP_1_1)
        .DELETE().build();

    HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
    if (response.statusCode() == 200) {
      UazapiLogoutResponse logoutResponseDto = om.readValue(response.body(), UazapiLogoutResponse.class);
      return logoutResponseDto;
    } else {
      throw new RuntimeException("Error al cerrar sesión " + response.body());
    }
  }

}