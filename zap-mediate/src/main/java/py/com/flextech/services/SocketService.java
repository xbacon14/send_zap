package py.com.flextech.services;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import com.corundumstudio.socketio.SocketIOClient;
import com.corundumstudio.socketio.SocketIOServer;

import io.quarkus.runtime.Startup;
import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@Startup
@ApplicationScoped
public class SocketService {
  private static Map<String, SocketIOClient> clientMap = new ConcurrentHashMap<>();
  private static Map<String, SocketIOClient> tenantMap = new ConcurrentHashMap<>();

  private static final String PUSH_GARCOM_EVENT = "atualiza";

  @Inject
  private SocketIOServer socketIOServer;

  @PostConstruct
  private void autoStartup() {
    start();
  }

  @PreDestroy
  private void autoStop() {
    stop();
  }

  public void start() {
    socketIOServer.addConnectListener(client -> {
      String clientIp = getIpByClient(client);
      System.out.println("************ USUARIO:" + clientIp + "CONECTADO************");
      String userId = getParamsByClient(client);
      // String tenant = getParamsByTenant(client);
      // if (tenant != null) {
      // System.out.println(clientIp + " *********************** " + "O usuario " +
      // userId + " da empresa: "
      // + tenant + " está conectado");
      // }
      client.sendEvent("connected", "Voce foi conectado correctamente ...");
      if (userId != null) {
        clientMap.put(userId, client);
      }
      // if (tenant != null) {
      // tenantMap.put(tenant, client);
      // }
    });
    socketIOServer.addDisconnectListener(client -> {
      String clientIp = getIpByClient(client);
      System.out.println(clientIp + " *********************** " + "O cliente foi desconectado");
      String userId = getParamsByClient(client);
      String tenant = getParamsByTenant(client);
      System.out.println(clientIp + " *********************** " + "O usuario  " + userId + "  da Empresa: "
          + tenant + " foi desconectado");
      if (userId != null) {
        clientMap.remove(userId);
      }
      if (tenant != null) {
        tenantMap.remove(tenant);
      }
      client.disconnect();
    });
    socketIOServer.addEventListener(PUSH_GARCOM_EVENT, String.class, (client, data, ackSender) -> {
      String clientIp = getIpByClient(client);
      System.out.println(clientIp + "************ " + PUSH_GARCOM_EVENT + " **************");
      System.out.println(clientIp + "************ Cliente:" + data);
    });

    socketIOServer.start();

  }

  public void stop() {
    if (socketIOServer != null) {
      socketIOServer.stop();
      socketIOServer = null;
    }
  }

  public void pushMessageToUser(String userId, String msgContent) {
    SocketIOClient client = clientMap.get(userId);
    if (client != null) {
      client.sendEvent(PUSH_GARCOM_EVENT, msgContent);
      System.out.println("Evento: " + PUSH_GARCOM_EVENT + " usuario: " + userId);
    }
  }

  public void pushMessageDifusao(String msgContent) {
    System.out.println("difusao");
    socketIOServer.getBroadcastOperations().sendEvent(PUSH_GARCOM_EVENT, msgContent);
  }

  /**
   * Obtenga el parámetro userId en la url del cliente (aquí puede modificarlo
   * según las necesidades personales y del cliente)
   *
   * @param cliente: cliente
   * @return: java.lang.String
   */
  private String getParamsByClient(SocketIOClient client) {
    // Obtener los parámetros de la URL del cliente (userId aquí es un identificador
    // único)
    Map<String, List<String>> params = client.getHandshakeData().getUrlParams();
    List<String> userIdList = params.get("userId");
    if (userIdList != null) {
      return userIdList.get(0);
    }
    // if (!clientMap.containsValue(userIdList)) {
    // return userIdList.get(0);
    // }
    return null;
  }

  private String getParamsByTenant(SocketIOClient client) {
    Map<String, List<String>> params = client.getHandshakeData().getUrlParams();
    List<String> list = params.get("tenant");
    if (list != null) {
      return list.get(0);
    }
    return null;
  }

  /**
   * Obtenga la dirección IP del cliente conectado
   *
   * @param cliente: cliente
   * @return: java.lang.String
   */
  private String getIpByClient(SocketIOClient client) {
    String sa = client.getRemoteAddress().toString();
    String clientIp = sa.substring(1, sa.indexOf(":"));
    return clientIp;
  }
}
