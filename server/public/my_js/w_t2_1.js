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
        max: 72,
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
                {value:65,name:'茂名市'},
{value:42,name:'湛江市'},
{value:33,name:'河源市'},
{value:33,name:'云浮市'},
{value:29,name:'阳江市'},

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