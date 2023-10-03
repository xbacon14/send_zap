package py.com.flextech.models.uazapi.session;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class UazapiLogoutResponse {
  private Boolean error;
  private String message;
}
