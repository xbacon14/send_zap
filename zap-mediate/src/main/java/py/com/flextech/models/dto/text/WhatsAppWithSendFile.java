package py.com.flextech.models.dto.text;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class WhatsAppWithSendFile {
  private String url;
  private String sessionKey;
  private String session;
  private String fileName;
  private String path;
  private String caption;
  private String number;
}
