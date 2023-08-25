package py.com.flextech.models.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import py.com.flextech.models.dto.text.Response;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ChatResponseDto {
  private String status;
  private List<Response> response;
  private String mapper;
  private String session;

}