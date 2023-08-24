package py.com.flextech.models;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.Lob;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StartSessionResponse {
  private String status;
  @Lob
  private String qrcode;
  @JsonIgnore
  private String urlcode;
  private String version;
}
