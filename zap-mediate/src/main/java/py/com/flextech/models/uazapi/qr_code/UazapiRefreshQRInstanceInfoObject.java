package py.com.flextech.models.uazapi.qr_code;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UazapiRefreshQRInstanceInfoObject {
  private String instanceName;
  @JsonIgnore
  private String apikey;
  private String owner;
  private String profileName;
  private String profilePictureUrl;

}
