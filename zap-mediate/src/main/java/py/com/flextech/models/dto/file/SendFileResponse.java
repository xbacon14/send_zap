package py.com.flextech.models.dto.file;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SendFileResponse {
  private String status;
  private List<FileResponse> response;
  private String mapper;
  private String session;

}
