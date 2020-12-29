<template>
    <el-table
    id="custable"
    :data=cus
    @expand-change="expandChange"
    style="width: 100%">
    <el-table-column type="expand">
      <template slot-scope="props">
        <el-form label-position="left" inline class="demo-table-expand">
          <div v-for="(ob,i) in cusOb[props.row.cus_id]" :key="i">
          <el-form-item label="订单号">{{ob.ob_order}}
          </el-form-item>
          <el-form-item label="订单日期">{{ob.ob_date}}
          </el-form-item>
          <el-form-item label="家具">{{ob.fur_name}}
          </el-form-item>
          <el-form-item label="购买数量">{{ob.ob_amount}}
          </el-form-item>
          <el-form-item label="收款">￥{{ob.ob_pay}}
          </el-form-item>
          </div>
        </el-form>
      </template>
    </el-table-column>
    <el-table-column
      label="客户编号"
      prop="cus_id">
    </el-table-column>
    <el-table-column
      label="客户名称"
      prop="cus_name">
    </el-table-column>
    <el-table-column
      label="性别"
      prop="cus_sex">
    </el-table-column>
    <el-table-column
      label="联系方式"
      prop="cus_tel">
    </el-table-column>
    </el-table>
</template>
<script>
import axios from 'axios'
export default {
  name: 'showCus',
  data: function(){
    return{
      cus: [],
      cusOb: {},
    }
  },
  mounted: function() {
    axios.get('http://niziqi.top:5000/getCus')
      .then((res)=>{
        console.log(res.data)
        this.cus = res.data
      })
  },
  methods:{
    expandChange(row, expandedRows) {
      if (expandedRows.length > 0) {
        axios.get('http://niziqi.top:5000/selectCusOb',{
          params:{
            cusId: row.cus_id
          }
        }).then((res)=>{
          let cusId = String(row.cus_id)
          this.cusOb[cusId]=res.data
          console.log(this.cusOb)
        })
      }
    }
  }
}
</script>
<style scoped>
#custable {
  margin-top: 30px;
  font-size: 18px;
  max-width: 961px;
}
</style>