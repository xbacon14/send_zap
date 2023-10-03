package py.com.flextech.models.uazapi.qr_code;

import io.quarkus.runtime.annotations.IgnoreProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import py.com.flextech.models.uazapi.session.UazapiCreateInstanceQrCode;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UazapiRefreshQRCodeResponse {
  private String instance;
  private UazapiConnectionStatus connectionStatus;
  private UazapiRefreshQRInstanceInfo instanceInfo;
  private UazapiCreateInstanceQrCode qrcode;
}
