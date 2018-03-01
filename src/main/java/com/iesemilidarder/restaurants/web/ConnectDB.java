package com.iesemilidarder.restaurants.web;

import java.sql.*;
import java.util.ArrayList;

/**
 * Llegeix les taules de la base de dades
 */

public class ConnectDB {
    public static ArrayList readRestaurant(String search) {
        ArrayList al = new ArrayList();
        try {

            Class.forName("oracle.jdbc.driver.OracleDriver");       // Driver per a que llegeixi la base de dades
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@35.205.41.45:1521:XE", "usuari","usuari");      //Connexió a la base de dades

            PreparedStatement pstmt;

            /**
             * If que mira si la cerca no té un valor null, i fa la query a la base de dades com a un preparedStatement,
             * i ho ordena per la seva nota.
             * Passa el resultat del cercador a lowercase per a que correspongui a les dades de la base de dades
             * Si el valor de la cerca és null, mostrarà tots els restaurants
             */

            if((search!=null && !search.equals(""))){
                pstmt = con.prepareStatement("SELECT * FROM (SELECT R.RES_NOM, R.RES_ADRECA, R.RES_WEB, R.RES_TELEFON, T.TRS_DESCRIPCIO, R.RES_URL_IMG, R.RES_CODI FROM RESTAURANTS R, TRESTAURANTS T WHERE RES_TRS_CODI = TRS_CODI AND LOWER(R.RES_NOM) LIKE ? ORDER BY RES_MITJANA ASC) WHERE ROWNUM <= 5");
                pstmt.setString(1, "%"+search.toLowerCase()+"%");
            }else{
                pstmt = con.prepareStatement("SELECT * FROM (SELECT R.RES_NOM, R.RES_ADRECA, R.RES_WEB, R.RES_TELEFON, T.TRS_DESCRIPCIO, R.RES_URL_IMG, R.RES_CODI FROM RESTAURANTS R, TRESTAURANTS T WHERE RES_TRS_CODI = TRS_CODI ORDER BY RES_MITJANA ASC) WHERE ROWNUM <= 5");
            }

            /**
             * ResultSet que executa la query a la base de dades, i el while fa que per cada valor que tengui el
             * resultset, assigni les taules als parametres.
             */

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {

                /**
                 * Assignació de les taules als parametres
                 */

                String name = rs.getString("RES_NOM");
                String address = rs.getString("RES_ADRECA");
                String website = rs.getString("RES_WEB");
                String telephone = rs.getString("RES_TELEFON");
                String type = rs.getString("TRS_DESCRIPCIO");
                String imgurl = rs.getString("RES_URL_IMG");
                String codi = rs.getString("RES_CODI");


                /**
                 * Creacio de l'objecte rst a partir de Restaurant, i li fa els setters a partir dels parametres
                 */

                Restaurant rst = new Restaurant();
                rst.setName(name);
                rst.setAddress(address);
                rst.setWebsite(website);
                rst.setTelephone(telephone);
                rst.setType(type);
                rst.setImgurl(imgurl);
                rst.setCodi(codi);


                al.add(rst);
            }
            pstmt.close();
            con.close();

        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return al;
    }


    /**
     * Metode per treure les opinions dels restaurants
     * @param id ID del restaurant. Cada restaurant tendra un ID diferent
     * @return rst
     */
    public static Restaurant readRestOpi(String id) {
        Restaurant rst = null;
        try {

            Class.forName("oracle.jdbc.driver.OracleDriver");       // Driver per a que llegeixi la base de dades
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@35.205.41.45:1521:XE", "usuari","usuari");      //Connexió a la base de dades

            PreparedStatement pstmt;
            PreparedStatement pstmtOpi;


            pstmt = con.prepareStatement("SELECT R.RES_NOM, R.RES_ADRECA, R.RES_WEB, R.RES_TELEFON, T.TRS_DESCRIPCIO, R.RES_URL_IMG, R.RES_CODI FROM RESTAURANTS R, TRESTAURANTS T WHERE RES_TRS_CODI = TRS_CODI AND RES_CODI='" + id + "'");

            /**
             * Query a la base de dades per treure els valors de les opinions en un prepared statement
             */
            pstmtOpi =  con.prepareStatement("SELECT O.OPI_OBSERVACIO, U.USU_NOM FROM OPINIONS O, RESTAURANTS R, USUARIS U WHERE O.OPI_RES_CODI = R.RES_CODI AND RES_CODI ='" + id + "' AND U.USU_CODI = O.OPI_USU_CODI");

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {


                String name = rs.getString("RES_NOM");
                String address = rs.getString("RES_ADRECA");
                String website = rs.getString("RES_WEB");
                String telephone = rs.getString("RES_TELEFON");
                String type = rs.getString("TRS_DESCRIPCIO");
                String imgurl = rs.getString("RES_URL_IMG");
                String codi = rs.getString("RES_CODI");

                rst = new Restaurant();

                rst.setName(name);
                rst.setAddress(address);
                rst.setWebsite(website);
                rst.setTelephone(telephone);
                rst.setType(type);
                rst.setImgurl(imgurl);
                rst.setCodi(codi);


                ResultSet rsOpi = pstmtOpi.executeQuery();

                /**
                 * While que mentres el resultset creat tengui valors, creara l'objecte opi a partir de Opinions
                 * i treura el valor de la base de dades, i el convertira en string
                 */

                while (rsOpi.next()){
                    Opinion opi = new Opinion();
                    String opinion = rsOpi.getString("OPI_OBSERVACIO");

                    /**
                     * Fa un set del valor de la base de dades a Opinions
                     */
                    opi.setDescription(opinion);

                    /**
                     * Afegeix el valor de les opinions al array que hi ha a Restaurant
                     */
                    rst.getOpinion().add(opi);

                }

            }
            con.close();


        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return rst;
    }


    /**
     * Treu les dades dels usuaris
     * @param user parametre del usuari
     * @param pass parametre de la contrasenya
     * @return
     */

    public static Users readLogin(String user, String pass) {

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");       // Driver per a que llegeixi la base de dades
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@35.205.41.45:1521:XE", "usuari", "usuari");

            PreparedStatement pstmtReadLogin;

            /**
             * Query on es dona el parametre d'usuari del forulari i la contrasenya, que a la vegada la encripta amb sha256
             */

            pstmtReadLogin = con.prepareStatement("SELECT USU_CODI,USU_ADRECA_ELECTRONICA,USU_NOM,USU_PASSWORD FROM USUARIS WHERE USU_CODI ='" + user + "' AND USU_PASSWORD ='" + Sha256.sha256(pass) + "'");


            /**
             * ResultSet que executa la query a la base de dades
             */
            ResultSet rs = pstmtReadLogin.executeQuery();

            /**
             * If que mentres el resultat tengui valors, assignara els valors de la base de dades als parametres.
             * Creara un objecte a partir de Users i fara set dels parametres trets de la base de dades.
             */
            if (rs.next()) {

                String code = rs.getString("USU_CODI");
                String username = rs.getString("USU_NOM");
                String password = rs.getString("USU_PASSWORD");
                String email = rs.getString("USU_ADRECA_ELECTRONICA");

                Users usr = new Users();

                usr.setCode(code);
                usr.setUsers(username);
                usr.setPassword(password);
                usr.setEmail(email);

                return usr;
            }

        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return null;
    }


    /**
     * Metode per insertar els comentaris dins la base de dades. Treu els valors que se li donen al CommentServlet, i
     * els utilitza per fer l'INSERT.
     * @param user Nom del usuari
     * @param comment Comentari o opinio
     * @param score Nota que se li dona
     * @param restCode Codi - id - del restaurant
     * @return
     */
    public static Users setComment(String user, String comment, String score, String restCode){
        try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@35.205.41.45:1521:XE", "usuari", "usuari");
            PreparedStatement pstmtSetComment;
            pstmtSetComment = con.prepareStatement("INSERT INTO OPINIONS (OPI_OBSERVACIO,OPI_PUNTUACIO,OPI_RES_CODI,OPI_USU_CODI,OPI_OPINIO_REVISADA) VALUES(?," + score + "," + restCode + ",'" + user + "','N')");
            pstmtSetComment.setString(1,comment);
            pstmtSetComment.executeUpdate();

            con.close();

        }catch(Exception e){
            System.out.println(e.toString());
        }
        return null;
    }

}
