package py.com.flextech.models.uazapi.qr_code;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UazapiConnectionStatus {

  private String state;
  private Long statusReason;
}
