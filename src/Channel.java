package zetta;
import com.google.appengine.api.datastore.Key;
import javax.jdo.annotations.IdentityType;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.PrimaryKey;

@PersistenceCapable(identityType = IdentityType.APPLICATION)
public class Channel {
	@PrimaryKey
    @Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
    private Key key;
	
	@Persistent
	private String name;
	
	@Persistent
	private int rank;
	
	@Persistent
	private String imgURL;
	
	public Channel(String name) {
		this.name = name; this.rank=32767; this.imgURL="";
	}
	
	public Channel(String name, int rank, String imgURL) {
		this.name = name; this.rank=rank; this.imgURL=imgURL;
	}
	
	public Key getKey() {
		return key;
	}
	
	public String getName() {
		return this.name;
	}
	
	public int getRank() {
		return this.rank;
	}
	
	public String getImgURL() {
		return this.imgURL;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public void setRank(int rank) {
		this.rank = rank;
	}
	
	public void setImgURL(String imgURL) {
		this.imgURL = imgURL;
	}
}

	