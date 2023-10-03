package py.com.flextech.models.uazapi.hook;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UazapiHookStatusInstanceData {
  private String instance;
  private String status;
}
