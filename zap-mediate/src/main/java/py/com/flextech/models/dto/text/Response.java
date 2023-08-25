package py.com.flextech.models.dto.text;

import java.util.ArrayList;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Response {
  public String id;
  public boolean viewed;
  public String body;
  public String type;
  public Object subtype;
  public int t;
  public String from;
  @JsonProperty("to")
  public String myto;
  public String self;
  public int ack;
  public boolean isNewMsg;
  public boolean star;
  public boolean kicNotified;
  public boolean isFromTemplate;
  public boolean pollInvalidated;
  public boolean isSentCagPollCreation;
  public Object latestEditMsgKey;
  public Object latestEditSenderTimestampMs;
  public ArrayList<Object> mentionedJidList;
  public ArrayList<Object> groupMentions;
  public Object urlText;
  public Object urlNumber;
  public boolean isVcardOverMmsDocument;
  public boolean isForwarded;
  public ArrayList<Object> labels;
  public boolean hasReaction;
  public String disappearingModeInitiator;
  public boolean productHeaderImageRejected;
  public int lastPlaybackProgress;
  public boolean isDynamicReplyButtonsMsg;
  public boolean isMdHistoryMsg;
  public int stickerSentTs;
  public boolean isAvatar;
  public int lastUpdateFromServerTs;
  public Object bizBotType;
  public boolean requiresDirectConnection;
  public Object invokedBotWid;
  public String chatId;
  public boolean fromMe;
  public Sender sender;
  public int timestamp;
  public String content;
  public boolean isGroupMsg;
  @JsonIgnore
  public MediaData mediaData;
}
