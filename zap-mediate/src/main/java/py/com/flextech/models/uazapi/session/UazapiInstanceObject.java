package py.com.flextech.models.uazapi.session;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UazapiInstanceObject {
  private String instanceName;
  private String status;
}
