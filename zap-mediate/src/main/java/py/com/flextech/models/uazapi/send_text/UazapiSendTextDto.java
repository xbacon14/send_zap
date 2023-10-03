package py.com.flextech.models.uazapi.send_text;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class UazapiSendTextDto {
  private String number;
  private UazapiTextMessage textMessage;
  private UazapiMessageOptions options;
}
