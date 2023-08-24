package py.com.flextech.models.dto;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
  @Setter
  @AllArgsConstructor
  @NoArgsConstructor
  public class Root {
    public String status;
    public ArrayList<Response> response;
    public String mapper;
    public String session;
  }