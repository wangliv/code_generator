package ${controllerpackage};

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;
import ${entitypackage}.${tableName};
import ${servicepackage}.${tableName}Service;

@Controller
@RequestMapping("/site/PVIP/${tableName?lower_case}")
public class ${tableName}Controller {

    @Autowired
    private ${tableName}Service service;


    /**
     * 页面跳转
     * @param form
     * @return
     */
    @RequestMapping(value = "/listView.ds")
    public ModelAndView preview() {
        ModelAndView mv = new ModelAndView("PVIP/${tableName?lower_case}/${tableName}");
        return mv;
    }

    /**
     * 查询列表
     * @param form
     * @return
     */
    @ResponseBody
    @RequestMapping("/list.ds")
    public String list(${tableName} form) {
        JSONObject returnObject = new JSONObject();
        try {
            List<${tableName}> list = service.list(form);
            JSONArray data = new JSONArray();
            list.forEach(t -> data.add(t));
            returnObject.put("data", data);
            returnObject.put("success", true);
            returnObject.put("count", list.size());
        } catch (Exception e) {
            returnObject.put("success", false);
            returnObject.put("error", e.getMessage());
        }
        return JSONObject.toJSONString(returnObject, SerializerFeature.WriteNullStringAsEmpty);
    }


    /**
    * 添加
    * @param form
    * @return
    */
    @RequestMapping("/add.ds")
    @ResponseBody
    public String add(${tableName} form) {
        JSONObject jsonObj = new JSONObject();
        try {
            service.add(form);
            jsonObj.put("success", true);
        } catch (Exception e) {
            jsonObj.put("success", false);
            jsonObj.put("erroMsg", e.getMessage());
        }
        return jsonObj.toJSONString();
    }

    /**
    * 删除
    * @param form
    * @return
    */
    @RequestMapping("/delete.ds")
    @ResponseBody
    public String delete(${tableName} form) {
        JSONObject jsonObj = new JSONObject();
        try {
            service.delete(form);
            jsonObj.put("success", true);
        } catch (Exception e) {
            jsonObj.put("success", false);
            jsonObj.put("erroMsg", e.getMessage());
        }
        return jsonObj.toJSONString();
    }

    /**
    * 修改
    * @param form
    * @return
    */
    @RequestMapping("/update.ds")
    @ResponseBody
    public String update(${tableName} form) {
    JSONObject jsonObj = new JSONObject();
        try {
            service.update(form);
            jsonObj.put("success", true);
        } catch (Exception e) {
            jsonObj.put("success", false);
            jsonObj.put("erroMsg", e.getMessage());
        }
            return jsonObj.toJSONString();
        }
    }
