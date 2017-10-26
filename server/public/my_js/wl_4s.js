option = {
    backgroundColor: '#ffffff',
    animation: false, // save image...

    title: {
        text: 'Customized Pie',
        left: 'center',
        top: 20,
        textStyle: {
            color: '#ccc'
        }
    },

    tooltip : {
        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
    },

    visualMap: {
        show: false,
        min: 0,
        max: 47,
        inRange: {
            colorLightness: [0, 1]
        }
    },
    series : [
        {
            name:'访问来源',
            type:'pie',
            radius : '55%',
            center: ['50%', '50%'],
            data:[
                //{value:335, name:'直接访问'}, {value:310, name:'邮件营销'},
                {value:43,name:'江苏天泓汽车服务有限公司'},
{value:21,name:'杭州诚新旧机动车置换有限公司'},
{value:20,name:'苏州建通汽车销售服务有限公司'},
{value:17,name:'泉州通海汽车销售服务有限公司'},
{value:17,name:'河北盛华汽车贸易有限公司'},
{value:17,name:'河北益通汽车销售服务有限公司'},

            ].sort(function (a, b) { return a.value - b.value; }),
            roseType: 'radius',
            label: {
                normal: {
                    textStyle: {
                        color: 'rgba(0, 0, 255, 1)'
                    }
                },
                //fontSize:260,
            },
            labelLine: {
                normal: {
                    lineStyle: {
                        color: 'rgba(0, 0, 255, 0.3)'
                    },
                    smooth: 0.2,
                    length: 10,
                    length2: 20
                }
            },
            itemStyle: {
                normal: {
                    color: '#c23531',
                    shadowBlur: 200,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
            },

            animationType: 'scale',
            animationEasing: 'elasticOut',
            animationDelay: function (idx) {
                return Math.random() * 200;
            }
        }
    ]
};