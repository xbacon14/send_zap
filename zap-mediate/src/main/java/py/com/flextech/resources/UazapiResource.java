package py.com.flextech.resources;

import org.apache.http.HttpStatus;

import jakarta.annotation.security.PermitAll;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

@Path("/uazapi")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class UazapiResource {

  // @Inject
  // private SocketService socketService;

  @GET
  @PermitAll
  @Path("/atualiza_qr_code")
  public Response atualizaQRCode() {
    System.out.println("atualiza qr code");
    // socketService.pushMessageToUser(instance.getInstance(),C "qrCode");
    return Response.ok("atualizado").status(HttpStatus.SC_ACCEPTED).build();

  }

}
