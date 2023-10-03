package py.com.flextech.models.uazapi.send_file;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import py.com.flextech.models.uazapi.send_text.UazapiMessageOptions;

@AllArgsConstructor
@Getter
@Setter
public class UazapiSendFile64Dto {
  private String number;
  private UazapiMessageOptions options;
  private UazapiMediaMessage mediaMessage;
}
