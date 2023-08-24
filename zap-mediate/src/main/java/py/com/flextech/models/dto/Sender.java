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
public class Sender {
  public String id;
  public String name;
  public String shortName;
  public String pushname;
  public String type;
  public String verifiedName;
  public boolean isBusiness;
  public boolean isEnterprise;
  public boolean isSmb;
  public int verifiedLevel;
  public Object privacyMode;
  public ArrayList<Object> labels;
  public int isContactSyncCompleted;
  public String formattedName;
  public boolean isMe;
  public boolean isMyContact;
  public boolean isPSA;
  public boolean isUser;
  public boolean isWAContact;
  public Object profilePicThumbObj;
  public Object msgs;
}
