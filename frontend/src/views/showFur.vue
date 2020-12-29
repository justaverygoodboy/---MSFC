<template>
    <div class="fur_pal">
        <div id="insert_fur">
        <el-input
            size="medium"
            placeholder="家具ID"
            v-model="fur_id">
        </el-input>
        <el-input
            size="medium"
            placeholder="家具名称"
            v-model="fur_name">
        </el-input>
        <el-input
            size="medium"
            placeholder="数量"
            v-model="fur_amount">
        </el-input>
        <el-input
            size="medium"
            placeholder="售价"
            v-model="fur_price">
        </el-input>
        <el-input
            size="medium"
            placeholder="类型ID"
            v-model="type_id">
        </el-input>
        <el-input
            size="medium"
            placeholder="供应商ID"
            v-model="sup_id">
        </el-input>
        <el-button type="primary" plain @click="insertFur" id="fur_inser_btn">插入</el-button>
        </div>
        <el-alert
            id="alert"
            title="提交错误！！请检查输入信息！！"
            type="error"
            center
            show-icon
            v-show="alert"
            closable=true>
        </el-alert>
        <el-table
        :data="furs"
        border
        id="furtable">
        <el-table-column
            prop="fur_id"
            label="家具编号"
            width="150">
        </el-table-column>
        <el-table-column
            prop="fur_name"
            label="家具名称"
            width="200">
        </el-table-column>
        <el-table-column
            prop="fur_amount"
            label="库存"
            width="100">
        </el-table-column>
        <el-table-column
            prop="fur_price"
            label="售价"
            width="120">
        </el-table-column>
        <el-table-column
            prop="sup_name"
            label="供应商"
            width="120">
        </el-table-column>
        <el-table-column
            prop="type_name"
            label="家具类型"
            width="120">
        </el-table-column>
        <el-table-column
            label="操作"
            width="150">
            <el-button type="primary" icon="el-icon-edit" plain></el-button>
            <el-button type="primary" icon="el-icon-delete" plain></el-button>
        </el-table-column>
        </el-table>
        <div class="type_sup">
            <div class="type">
                <el-button type="info" plain @click="showType">展示家具类型</el-button>
                <el-table
                :data="types"
                border
                v-show="typeTable"
                id="furtype">
                <el-table-column
                    prop="type_id"
                    label="类型编号"
                    width="150">
                </el-table-column>
                <el-table-column
                    prop="type_name"
                    label="类型名称"
                    width="200">
                </el-table-column>
                </el-table>
            </div>
            <div class="sup">
                <el-button type="info" plain @click="showSup">展示供应商</el-button>
                <el-table
                :data="sups"
                border
                v-show="supTable"
                id="fur_sup">
                <el-table-column
                    prop="sup_id"
                    label="供应商编号"
                    width="150">
                </el-table-column>
                <el-table-column
                    prop="sup_name"
                    label="供应商名称"
                    width="200">
                </el-table-column>
                <el-table-column
                    prop="sup_tel"
                    label="联系电话"
                    width="200">
                </el-table-column>
                </el-table>
            </div>
        </div>
    </div>
</template>
<script>
import axios from 'axios'

export default {
  name: 'showFur',
  data: function(){
    return{
      furs: [],
      sups: [],
      types: [],
      supTable:0,
      typeTable:0,
      alert:0,

      fur_id:'',
      fur_name:'',
      fur_amount:'',
      fur_price:'',
      sup_id:'',
      type_id:'',
    }
  },
  mounted: function() {
      axios.get('http://niziqi.top:5000/getFur')
      .then((res)=>{
        console.log(res.data)
        this.furs = res.data
      })
  },
  methods:{
    showFur:function(){
      axios.get('http://niziqi.top:5000/getFur')
      .then((res)=>{
        console.log(res.data)
        this.furs = res.data
      })
    },
    showType:function(){
      axios.get('http://niziqi.top:5000/type')
      .then((res)=>{
        console.log(res.data)
        this.types = res.data
        this.typeTable=1
      })
    },
    showSup:function(){
      axios.get('http://niziqi.top:5000/sup')
      .then((res)=>{
        console.log(res.data)
        this.sups = res.data
        this.supTable=1
      })
    },
    insertFur:function(){
      axios.post('http://niziqi.top:5000/insertFur',{
        furId:this.fur_id,
        furName:this.fur_name,
        furAmount:this.fur_amount,
        furPrice:this.fur_price,
        typeId:this.type_id,
        supId:this.sup_id
      }).then(
        this.showFur()
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
.fur_pal {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}
#furtable {
  margin-top: 30px;
  font-size: 18px;
  max-width: 961px;
}
#insert_fur {
  margin-top: 70px;
  width:50%;
  display: flex;
  align-items: center;
}
#fur_inser_btn {
    margin-left: 10px;
}
.type {
    margin-right: 20px;
}
.type_sup {
  margin-top: 50px;
  display: flex;
  justify-content: center;
  /* align-items: center; */
}
#furtype {
  margin-top: 30px;
  font-size: 18px;
}
#fur_sup {
  margin-top: 30px;
  font-size: 18px;
}
</style>