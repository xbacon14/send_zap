package py.com.flextech.services;

import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import py.com.flextech.models.dto.GenerateTokenResponse;

@RegisterRestClient(baseUri = "http://localhost:21465/api")
public interface AuthService {

  @POST
  @Path("/{sessionKey}/{wppSecret}/generate-token")
  public GenerateTokenResponse generateToken(@PathParam("sessionKey") String sessionKey,
      @PathParam("wppSecret") String wppSecret);

  @GET
  @Path("/{wppSecret}/show-all-sessions")
  public String showAllSessions(@PathParam("wppSecret") String sessionKey);

}