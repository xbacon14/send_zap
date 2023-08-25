package py.com.flextech.models.dto.text;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Sender {
  private String id;
  private String name;
  private String shortName;
  private String pushname;
  private String type;
  private String verifiedName;
  private Boolean isEnterprise;
  private Boolean isSmb;
  private Long verifiedLevel;
  private Object privacyMode;
  private Boolean forcedBusinessUpdateFromServer;
  private Boolean isBusiness;
  private ArrayList<Object> labels;
  private Long isContactSyncCompleted;
  private String formattedName;
  private Boolean isMe;
  private Boolean isMyContact;
  private Boolean isPSA;
  private Boolean isUser;
  private Boolean isWAContact;
  private Object profilePicThumbObj;
  private Object msgs;
}
