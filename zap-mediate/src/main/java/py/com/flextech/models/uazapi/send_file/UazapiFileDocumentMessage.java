package py.com.flextech.models.uazapi.send_file;

import io.quarkus.runtime.annotations.IgnoreProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class UazapiFileDocumentMessage {
  private String url;
  private String mimetype;
  private String fileSha256;
  private String fileLength;
  private String mediaKey;
  private String fileName;
  private String fileEncSha256;
  private String directPath;
  private String mediaKeyTimestamp;
  @IgnoreProperty
  private String contextInfo;
  private String caption;
}
