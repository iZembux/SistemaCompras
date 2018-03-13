package servlet;

import com.google.gson.Gson;
import controller.Consultas;
import java.io.IOException;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Item;

public class JsonServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

        String sportsName = request.getParameter("sportsName");
         System.out.println("Llegaaaaa" + sportsName);
        ArrayList<Item> list2 = new ArrayList<Item>();
        List<String> list = new ArrayList<String>();
        String json;

        Consultas obj = new Consultas();
        list2 = obj.consultarItems2(sportsName);

        list.add(list2.get(0).getMarca());

        json = new Gson().toJson(list);
        response.setContentType("application/json");
        response.getWriter().write(json);
    }
}
