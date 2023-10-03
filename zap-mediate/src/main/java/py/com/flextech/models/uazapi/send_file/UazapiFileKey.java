package py.com.flextech.models.uazapi.send_file;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class UazapiFileKey {
  private String remoteJid;
  private Boolean fromMe;
  private String id;
}
