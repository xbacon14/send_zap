package py.com.flextech.models.uazapi.session;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UazapiCreateInstanceQrCode {
  private String code;
  private String base64;
}
