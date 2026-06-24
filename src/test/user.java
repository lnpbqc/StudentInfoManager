import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class user {
    private int id;
    private String name;
    private String address;

    @Override
    public String toString() {
        return "user{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", address='" + address + '\'' +
                '}';
    }
}
