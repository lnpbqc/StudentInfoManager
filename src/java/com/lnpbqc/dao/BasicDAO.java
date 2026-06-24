package com.lnpbqc.dao;

import com.lnpbqc.util.JDBCUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.Connection;
import java.util.List;

public class BasicDAO <T>{
    private final QueryRunner queryRunner = new QueryRunner();
    public int update(String sql,Object... parameters){
        Connection connection = null;
        try{
            connection = JDBCUtils.getConnection();
            return queryRunner.update(connection, sql, parameters);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            JDBCUtils.close(null,null,connection);
        }
        return 0;
    }

    public List<T> queryMulti(String sql, Class<T> c, Object... parameters){
        Connection connection = null;
        try{
            connection = JDBCUtils.getConnection();
            return queryRunner.query(connection,sql,new BeanListHandler<>(c),parameters);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            JDBCUtils.close(null,null,connection);
        }
        return null;
    }

    public T querySingle(String sql,Class<T> c,Object... parameters){
        Connection connection =null;
        try{
            connection = JDBCUtils.getConnection();
            return queryRunner.query(connection,sql,new BeanHandler<>(c),parameters);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            JDBCUtils.close(null,null,connection);
        }
        return null;
    }

    public Object queryScalar(String sql,Object...parameters){
        Connection connection = null;
        try{
            connection = JDBCUtils.getConnection();
            return queryRunner.query(connection,sql,new ScalarHandler<>(),parameters);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            JDBCUtils.close(null,null,connection);
        }
        return null;
    }

}
