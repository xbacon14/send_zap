package py.com.flextech.models.dto.text;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class WhatsAppSendFileDto {

  private String phone;
  private String path;
  private String base64;
  private String filename;
  private String message;
  private String caption;
}
