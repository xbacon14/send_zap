package py.com.flextech.models.dto.text;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SendMessage {
  private String session;
  private String phone;
  private String message;
}
