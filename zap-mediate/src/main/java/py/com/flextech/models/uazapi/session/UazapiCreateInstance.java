package py.com.flextech.models.uazapi.session;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class UazapiCreateInstance {
  private String instanceName;
  private String apikey;
}
