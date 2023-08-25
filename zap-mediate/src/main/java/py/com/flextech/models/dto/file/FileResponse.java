package py.com.flextech.models.dto.file;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class FileResponse {
  private Long ack;
  private String id;
  private FileMessageResult sendMsgResult;
}
