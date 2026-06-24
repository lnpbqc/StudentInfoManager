import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.digest.DigestUtil;
import com.lnpbqc.dao.BasicDAO;
import com.lnpbqc.po.punish_levels;
import java.util.ArrayList;
import java.util.List;

public class test {
    public static void main(String[] args) {
        BasicDAO objectBasicDAO = new BasicDAO();
        String sql = "insert into admin values(?,?)";
        String name = "cbn";
        String pwd = DigestUtil.md5Hex("lnpbqc");
        int update = objectBasicDAO.update(sql, name,pwd);
        System.out.println(update);

    }
}
