__precompile__()

module PhyloTrees

# Dependencies
using RecipesBase

# Methods expanded
import Base.show, Base.push!, Base.append!, Base.getindex

# Functions provided
export
    # Trees
    AbstractTree,
    SimpleTree,
    Tree, BinaryTree,
    LeafTree,
    getnodes,
    getbranches,
    verify,
    getnode,
    getbranch,
    setnode!,
    setbranch!,

    # Nodes
    AbstractNode,
    Node,
    BinaryNode,
    indegree,
    getinbound,
    setinbound!,
    deleteinbound!,
    hasinbound,
    outdegree,
    hasoutboundspace,
    getoutbounds,
    addoutbound!,
    deleteoutbound!,
    isroot,
    isleaf,
    isinternal,
    isnode,
    isunattached,
    
    # Branches
    Branch,
    getsource,
    gettarget,
    getlength,
    changesource!,
    changetarget!,
    
    # Utilities
    addnode!,
    addnodes!,
    addbranch!,
    branch!,
    changesource!,
    changetarget!,
    deletenode!,
    deletebranch!,
    findroots,
    findleaves,
    findnodes,
    findnonroots,
    findnonleaves,
    findnonnodes,
    areconnected,
    nodepath,
    branchpath,
    parentnode,
    childnodes,
    descendantcount,
    descendantnodes,
    ancestorcount,
    ancestornodes,
    nodetype,

    # Distance
    distance,

    # Traversal
    postorder

module Interface
export
    _getnodes,
    _getbranches,
    _addnode!,
    _addbranch!,
    _hasnode,
    _hasbranch,
    _addnodes!,
    _deletenode!,
    _deletebranch!,
    _branch!,
    _getleafrecord,
    _verify,
    _newnodelabel,
    _newbranchlabel,
    _hasinbound,
    _outdegree,
    _hasoutboundspace,
    _getinbound,
    _setinbound!,
    _deleteinbound!,
    _getoutbounds,
    _addoutbound!,
    _deleteoutbound!,
    _indegree,
    _isroot,
    _isleaf,
    _isinternal,
    _isunattached,
    _getsource,
    _gettarget,
    _getlength,
    _setsource!,
    _settarget!
end

# Package files
include("interface.jl")
include("structure.jl")
include("show.jl")
include("construction.jl")
include("utilities.jl")
include("distance.jl")
include("traversal.jl")
include("plot.jl")


end
