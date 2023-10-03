package py.com.flextech.models.dto.file;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ResponseToComercial {
  private Long result;
  private String messages;
  public ResponseToComercial(Long result) {
    this.result = result;
  }

  
}
