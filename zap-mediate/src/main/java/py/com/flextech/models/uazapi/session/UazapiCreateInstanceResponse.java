package py.com.flextech.models.uazapi.session;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UazapiCreateInstanceResponse {
  private UazapiInstanceObject instance;
  private UazapiCreateInstanceHash hash;
  private UazapiCreateInstanceQrCode qrcode;

  public UazapiCreateInstanceResponse(UazapiCreateInstanceHash hash) {
    this.hash = hash;
  }

}
