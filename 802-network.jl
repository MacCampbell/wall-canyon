using PhyloNetworks;    
using CSV, DataFrames;     

CF=readTableCF("/home/maccamp/wall-canyon/outputs/802/network-nq3-btsp.csv");    

using PhyloPlots;    
treefile = joinpath("/home/maccamp/wall-canyon/outputs/802/tree.tre");
tree = readTopology(treefile);     
#plot(tree, :R, showEdgeLength=true);

T=readTopologyLevel1(treefile);    

# Using snaq!
net0 = snaq!(T,CF, hmax=0, filename="/home/maccamp/wall-canyon/outputs/802/net0", seed=1234);      
writeTopology(net0, "/home/maccamp/wall-canyon/outputs/802/bestnet-h0.tre")

net1 = snaq!(T,CF, hmax=1, filename="/home/maccamp/wall-canyon/outputs/802/net1", seed=1234);  
writeTopology(net1, "/home/maccamp/wall-canyon/outputs/802/bestnet-h1.tre")

net2 = snaq!(T,CF, hmax=2, filename="/home/maccamp/wall-canyon/outputs/802/net2", seed=1234);      
writeTopology(net2, "/home/maccamp/wall-canyon/outputs/802/bestnet-h2.tre")

net3 = snaq!(T,CF, hmax=3, filename="/home/maccamp/wall-canyon/outputs/802/net3", seed=1234);      
writeTopology(net3, "/home/maccamp/wall-canyon/outputs/802/bestnet-h3.tre")

net4 = snaq!(T,CF, hmax=4, filename="/home/maccamp/wall-canyon/outputs/802/net4", seed=1234);      
writeTopology(net4, "/home/maccamp/wall-canyon/outputs/802/bestnet-h4.tre")


using RCall      
imagefilename = "outputs/802/snaqplot-net0.pdf"
R"pdf"(imagefilename, width=4, height=3) 
R"par"(mar=[0,0,0,0]) 
plot(net0, showgamma=true, showedgenumber=true);
R"dev.off()"; 

using RCall     
imagefilename = "outputs/802/snaqplot-net1.pdf"
R"pdf"(imagefilename, width=4, height=3) 
R"par"(mar=[0,0,0,0]) 
plot(net1, showgamma=true, showedgenumber=true); 
R"dev.off()"; 

using RCall      
imagefilename = "outputs/802/snaqplot-net2.pdf"
R"pdf"(imagefilename, width=4, height=3) 
R"par"(mar=[0,0,0,0]) # to reduce margins 
plot(net2, showgamma=true, showedgenumber=true);
R"dev.off()"; 


scores = [net0.loglik, net1.loglik, net2.loglik, net3.loglik, net4.loglik]
hmax = collect(0:4)

using RCall      
imagefilename1 = "outputs/802/hscores.pdf"
R"pdf"(imagefilename1, width=4, height=3) 
R"par"(mar=[0,0,0,0]) 
R"plot"(hmax, scores, type="b", ylab="network score", xlab="hmax", col="blue");
R"dev.off()";

exit()
