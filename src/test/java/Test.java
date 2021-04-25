import io.github.homxuwang.utils.PasswordUtil;
import io.github.homxuwang.utils.SaltUtil;

/**
 * @Author homxu
 * @Date 2021/4/21 11:15
 * @Version 1.0
 */
public class Test {

    public void Main(String[] args){
        String salt = SaltUtil.generatorSalt();
        System.out.println("salt: " + salt);

        String password = PasswordUtil.getSaltPassword("12345678",salt);
        System.out.println("password: " + password);
    }
}
