package com.example.dao.impl;

import com.example.dao.PurchaseRecordDao;
import com.example.entity.PurchaseRecord;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class PurchaseRecordDaoImpl implements PurchaseRecordDao {

    @Resource
    private JdbcTemplate jdbcTemplate;

    @Override
    public void save(PurchaseRecord record) {
        String sql = "INSERT INTO purchase_records (user_id, book_id, price, purchase_time) VALUES (?, ?, ?, NOW())";
        jdbcTemplate.update(sql, record.getUserId(), record.getBookId(), record.getPrice());
    }

    @Override
    public boolean existsByUserIdAndBookId(Integer userId, Integer bookId) {
        String sql = "SELECT COUNT(*) FROM purchase_records WHERE user_id = ? AND book_id = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, userId, bookId);
        return count != null && count > 0;
    }

    @Override
    public List<PurchaseRecord> findByUserId(Integer userId) {
        String sql = "SELECT * FROM purchase_records WHERE user_id = ? ORDER BY purchase_time DESC";
        return jdbcTemplate.query(sql, new PurchaseRecordMapper(), userId);
    }

    private static class PurchaseRecordMapper implements RowMapper<PurchaseRecord> {
        @Override
        public PurchaseRecord mapRow(ResultSet rs, int rowNum) throws SQLException {
            PurchaseRecord record = new PurchaseRecord();
            record.setId(rs.getInt("id"));
            record.setUserId(rs.getInt("user_id"));
            record.setBookId(rs.getInt("book_id"));
            record.setPrice(rs.getBigDecimal("price"));
            record.setPurchaseTime(rs.getTimestamp("purchase_time"));
            return record;
        }
    }
}
