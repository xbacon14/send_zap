package py.com.flextech.config;

import org.eclipse.microprofile.config.inject.ConfigProperty;

import com.corundumstudio.socketio.SocketIOServer;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.inject.Produces;
import jakarta.inject.Inject;

@ApplicationScoped
public class SocketConfig {

  @Inject
  @ConfigProperty(name = "socketio.host")
  private String host;

  @Inject
  @ConfigProperty(name = "socketio.port")
  private Integer port;

  @Inject
  @ConfigProperty(name = "socketio.bossCount")
  private int bossCount;

  @Inject
  @ConfigProperty(name = "socketio.workCount")
  private int workCount;

  @Inject
  @ConfigProperty(name = "socketio.allowCustomRequests")
  private boolean allowCustomRequests;

  @Inject
  @ConfigProperty(name = "socketio.upgradeTimeout")
  private int upgradeTimeout;

  @Inject
  @ConfigProperty(name = "socketio.pingTimeout")
  private int pingTimeout;

  @Inject
  @ConfigProperty(name = "socketio.pingInterval")
  private int pingInterval;

  @Produces
  public SocketIOServer socketIOServer() {
    // SocketConfig socketConfig = new SocketConfig();
    // socketConfig.setTcpNoDelay(true);
    // socketConfig.setSoLinger(0);
    com.corundumstudio.socketio.Configuration config = new com.corundumstudio.socketio.Configuration();
    // config.setSocketConfig(socketConfig);
    config.setHostname(host);
    config.setPort(port);
    config.setBossThreads(bossCount);
    config.setWorkerThreads(workCount);
    config.setAllowCustomRequests(allowCustomRequests);
    config.setUpgradeTimeout(upgradeTimeout);
    config.setPingTimeout(pingTimeout);
    config.setPingInterval(pingInterval);
    return new SocketIOServer(config);
  }
}
