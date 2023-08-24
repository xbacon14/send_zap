package py.com.flextech.models.dto;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "sys_session")
@AllArgsConstructor
@NoArgsConstructor
public class GenerateTokenResponse {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @Column(name = "status")
  private String status;

  @Column(name = "session")
  private String session;

  @Column(name = "token")
  private String token;

  @Column(name = "full")
  private String full;

}
