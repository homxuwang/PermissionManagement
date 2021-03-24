package io.github.homxuwang.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * @Author homxu
 * @Date 2021/3/24 9:55
 * @Version 1.0
 * @Description Swagger的配置类
 */
@Configuration
@EnableSwagger2 //开启swagger功能
public class SwaggerConfig {

    @Bean
    public Docket createRestApi(){
        return new Docket(DocumentationType.SWAGGER_2) //DocumentationType.SWAGGER_2固定的，代表swagger2
                //.groupName("后台管理系统")  //如果配置多个文档的时候，需要配置groupName来分组标识
                .apiInfo(apiInfo()) //用于生成API信息
                .select() //select()函数返回一个ApiSelectorBuilder实例，用来控制接口被swagger做成文档
                .apis(RequestHandlerSelectors.basePackage("io.github.homxuwang.controller")) //用于指定扫描哪个包
                .paths(PathSelectors.any()) //选择所有的API，如果你想只为部分API生成文档，可以配置这里
                .build();
    }

    /**
     * 用于定义API主界面的信息，比如可以声明所有的API的总标题、描述、版本
     * @return
     */
    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                .title("后台管理系统 API") //自定义API的主题
                .description("后台管理系统-API管理") //描述整体的API
                .termsOfServiceUrl("") //定义服务的域名
                .version("1.0")    //定义版本
                .build();

    }
}
