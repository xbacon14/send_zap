package py.com.flextech.models.uazapi.send_file;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class UazapiMediaMessage {
  private String mediatype;
  private String fileName;
  private String caption;
  private String media;

}
