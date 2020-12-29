<template>
    <div class="ob_pal">
        <div id="insert_ob">
        <el-input
            size="medium"
            placeholder="订单ID"
            v-model="obOrder">
        </el-input>
        <el-input
            size="medium"
            placeholder="数量"
            v-model="obAmount">
        </el-input>
        <el-input
            size="medium"
            placeholder="时间"
            v-model="obDate">
        </el-input>
        <el-input
            size="medium"
            placeholder="家具ID"
            v-model="furId">
        </el-input>
        <el-input
            size="medium"
            placeholder="顾客ID"
            v-model="cusId">
        </el-input>
        <el-input
            size="medium"
            placeholder="售价"
            v-model="obPrice">
        </el-input>
        <el-button type="primary" plain @click="insertOb" id="ob_inser_btn">插入</el-button>
        </div>
        <el-table
        :data="obs"
        border
        id="obtable">
        <el-table-column
            prop="ob_order"
            label="销售订单号"
            width="150">
        </el-table-column>
        <el-table-column
            prop="ob_amount"
            label="销售数量"
            width="120">
        </el-table-column>
        <el-table-column
            prop="ob_date"
            label="销售时间"
            width="150">
        </el-table-column>
        <el-table-column
            prop="fur_id"
            label="销售家具"
            width="120">
        </el-table-column>
        <el-table-column
            prop="cus_id"
            label="客户ID"
            width="120">
        </el-table-column>
        <el-table-column
            prop="ob_price"
            label="销售价格"
            width="120">
        </el-table-column>
        <el-table-column
            label="操作"
            width="150">
            <el-button type="primary" icon="el-icon-edit" plain></el-button>
            <el-button type="primary" icon="el-icon-delete" plain></el-button>
        </el-table-column>
        </el-table>
        <div class="block">
        <el-date-picker
            v-model="stedDate"
            type="daterange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期">
        </el-date-picker>
        <el-button id="get_io_btn" type="primary" plain @click="getIO">查询</el-button>
        </div>
        <el-table
        :data="ios"
        v-show="iotables"
        border
        id="iotable">
        <el-table-column
            prop="fur_id"
            label="家具编号"
            width="120">
        </el-table-column>
        <el-table-column
            prop="total_in"
            label="总进货"
            width="150">
        </el-table-column>
        <el-table-column
            prop="total_out"
            label="总销售"
            width="150">
        </el-table-column>
        </el-table>
    </div>
</template>
<script>
import axios from 'axios'

export default {
  name: 'outBound',
  data: function(){
    return{
      obs: [],
      stedDate: [],
      ios:[],
      iotables:0,
      obOrder:'',
      obAmount:'',
      obDate:'',
      furId:'',
      cusId:'',
      obPrice:'',
    }
  },
  mounted: function() {
    axios.get('http://niziqi.top:5000/ob')
      .then((res)=>{
        console.log(res.data)
        this.obs = res.data
      })
  },
  methods:{
    showOb:function() {
        axios.get('http://niziqi.top:5000/ob')
        .then((res)=>{
        console.log(res.data)
        this.obs = res.data
      })
      },
    getIO:function(){
          this.iotables=1
          let stdate = this.DateToString(this.stedDate[0])
          let eddate = this.DateToString(this.stedDate[1])
          axios.get('http://niziqi.top:5000/getTotalIO',{
          params:{
            stDate: stdate,
            edDate: eddate
          }})
          .then((res)=>{
              console.log(res.data)
              this.ios = res.data
          }
          )
      },
    DateToString:function (date){ 
        let  year = date.getFullYear()
        let  month =(date.getMonth() + 1).toString() 
        let  day = (date.getDate()).toString()  
        if  (month.length == 1) { 
            month =  "0"  + month 
        } 
        if  (day.length == 1) { 
            day =  "0"  + day
        }
        let  dateTime = year +  "-"  + month +  "-"  + day
        return  dateTime
      },
    insertOb:function(){
      axios.post('http://niziqi.top:5000/insertOb',{
        furId:this.furId,
        obOrder:this.obOrder,
        obAmount:this.obAmount,
        obPrice:this.obPrice,
        obDate:this.obDate,
        cusId:this.cusId
      }).then(
        this.showOb()
      ).catch(
        this.$alert('注意提交正确的信息！！', '插入错误！', {
          confirmButtonText: '确定',
        }))
    }
  }
}
</script>
<style scoped>
.el-input {
    margin-left: 5px;
}
.ob_pal {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}
.block {
    margin-top: 60px;
}
#get_io_btn {
    margin-left: 10px;
}
#insert_ob {
  margin-top: 70px;
  width:100%;
  display: flex;
  align-items: center;
}
#ob_inser_btn {
    margin-left: 10px;
}
#obtable {
  margin-top: 30px;
  font-size: 18px;
  max-width: 931px;
}
#iotable {
  margin-top: 30px;
  font-size: 18px;
  max-width: 421px;
}
#insert_ob {
  margin-top: 70px;
  width:50%;
  display: flex;
}
</style>