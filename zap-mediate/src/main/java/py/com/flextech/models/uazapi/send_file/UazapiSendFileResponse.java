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
public class UazapiSendFileResponse {
  @IgnoreProperty
  private UazapiFileKey key;
  @IgnoreProperty
  private UazapiFileMessage message;
  private String messageTimestamp;
  private String status;
}
