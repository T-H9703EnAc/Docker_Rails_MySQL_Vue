<template>
    <div>
        <button @click="search" type="button" class="btn btn-primary">検索</button>
        <table class="table">
            <thead>
                <tr>
                <th scope="col">ID</th>
                <th scope="col">ユーザ名</th>
                </tr>
            </thead>
            <tbody>   
                <tr  v-for="item in items" :key="item.message">
                    <th scope="row">{{item.id}}</th>
                    <td>{{item.name}}</td>
                </tr>   
            </tbody>
        </table>
    </div>
</template>
<script>
    import axios from 'axios';
    export default {
        data(){
            return{
                items: []
            }
        },
        methods: {
            search (){
                axios
                .get('http://localhost:8080/search')
                .then(
                    response => {
                        for (let i=0; i<response.data.length; i++) {
                            this.items.push(response.data[i]);
                        }
                        console.log(this.items);
                    } 
                ).catch(
                    error => {
                        let errorData1 = {id: 2, name: "Jirou"};
                        let errorData2 = {id: 3, name: "Saburou"};
                        this.items.push(errorData1);
                        this.items.push(errorData2);
                    }
                );
            }
        }
    }
</script>