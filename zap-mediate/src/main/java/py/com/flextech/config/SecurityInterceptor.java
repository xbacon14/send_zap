package py.com.flextech.config;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.eclipse.microprofile.config.inject.ConfigProperty;

import jakarta.annotation.Priority;
import jakarta.inject.Inject;
import jakarta.ws.rs.container.ContainerRequestContext;
import jakarta.ws.rs.container.ContainerRequestFilter;
import jakarta.ws.rs.ext.Provider;

@Provider
@Priority(1)
public class SecurityInterceptor implements ContainerRequestFilter {

  @ConfigProperty(name = "wpp.secret")
  @Inject
  private String secret;

  @Override
  public void filter(ContainerRequestContext requestContext) throws IOException {
    List<String> allowedUri = new ArrayList<String>();
    allowedUri.add("/api/generate-token");
    allowedUri.add("/api/show");
    allowedUri.add("/api/qrcode");
    // allowedUri.add("/api/start/*");
    if (!allowedUri.contains(requestContext.getUriInfo().getPath())) {
      String authorizationHeader = requestContext.getHeaderString("Authorization");
      if (authorizationHeader == null || !authorizationHeader.equals(secret)) {
        requestContext
            .abortWith(jakarta.ws.rs.core.Response.status(jakarta.ws.rs.core.Response.Status.UNAUTHORIZED).build());
      }
    }
  }

}
